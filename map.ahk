#Requires AutoHotKey v2.0-beta.3
>+p::  Send        '{Up}'
>+l::  Send        '{Left}'
>+;::  Send        '{Down}'
>+"::  Send        '{Right}'

<+>+p::Send '{Blind}{U}'
<+>+l::Send '{Blind}{Left}'
<+>+;::Send '{Blind}{Down}'
<+>+"::Send '{Blind}{Right}'

$CapsLock::Ctrl

