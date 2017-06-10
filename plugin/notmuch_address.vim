" Complete addresses with notmuch address
"
" `g:notmuch_address_tag` - limit search to the name of your address book tag.

if exists("g:notmuch_address")
  finish
else
  let g:notmuch_address = 1
endif

function! CompleteNotmuchAddress(findstart, base)
  let curline = getline('.')
  if curline =~ '^From: ' || curline =~ '^To: ' || curline =~ '^Cc: ' || curline =~ '^Bcc: '
    if a:findstart
      " locate the start of the word
      let header_limit = stridx(curline, ": ") + 2 " Find end of the header
      let start = col('.') - 1
      while start > header_limit && curline[start - 2] != ","
        let start -= 1
      endwhile
      return start
    else
      if a:base =~ ':'
        " Assume this is a notmuch search query using notmuch-search-terms(7)
        let search_prefix = ""
        let query=shellescape(a:base)
      else
        " Only search mailboxes from the From: line
        let search_prefix = "from:"

        " Add wildcard for partial match
        let query = shellescape(a:base . '*')
      endif

      let address_tag = ""
      if exists("g:notmuch_address_tag")
        let address_tag = "tag:" . shellescape(g:notmuch_address_tag)
      endif

      let ncommand = "notmuch address -- " . address_tag . " " . search_prefix . query
      for m in systemlist(ncommand)
        if complete_check()
          break
        endif

        call complete_add(m)
      endfor
      return []
    endif
  endif
endfunction

augroup notmuch_address
  au!
  au FileType mail,notmuch-compose setlocal completefunc=CompleteNotmuchAddress
augroup END
