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
      let start = col('.') - 1
      while start > 0 && curline[start - 2] != ":" && curline[start - 2] != ","
        let start -= 1
      endwhile
      return start
    else
      let address_tag = ""
      if exists("g:notmuch_address_tag")
        let address_tag = "tag:" . shellescape(g:notmuch_address_tag)
      endif
      for m in systemlist("notmuch address -- " . address_tag . " from:" . shellescape(a:base))
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
