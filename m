From: Yury Krivopalov <ykrivopalov@yandex.ru>
Subject: Automounting of smb shares with dollar sign
Date: Thu, 30 Jun 2016 13:21:04 +0300
Message-ID: <974581467282064@web15m.yandex.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----==--bound.97459.web15m.yandex.ru"
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1467282065;
	bh=wSI32xIPndmFppp2HLkyXrjycpM214DRi3ZYoL2cJMY=;
	h=From:To:Subject:MIME-Version:Message-Id:X-Mailer:Date:
	 Content-Type;
	b=BdGg1cFaZfIC39EnkhTN9kgUwGXdpclA6yPTPFgf7Jww8l8hZp2CxiRX+2tYrGByg
	 j4tkVLZWiZjXdHpmRAY/AgDirVwaHNmJwCCFg/RWl0fJXGtk5aRb9XCCQTj9t9573S
	 esEXbPwEujQiznsd6v7MGCysVpmHOLcvtkI4Ykrw=
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: autofs@vger.kernel.org


------==--bound.97459.web15m.yandex.ru
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

Hello,
I found a problem, that started to reproduce on my new environment (archlinux), before that I used Debian Wheezy and everything worked fine.
The point is that I can't automount smb shares with dollar sign (Ex.: //hostname/C$).
 
It happend because two facts:
1. Autofs reads '$' as a special symbol
2. mount.cifs reads '\\' as a delimiter
 
So in my case if I returns "//hostname/C$" from auto.smb, then automount daemon replace '$' to '' and if I returns "//hostname/C\\$" then mount.cifs crops "\\$" and uses '$' as a prefixpath mount option.
 
I attached simple fix for autofs-5.1.2, that drops back slash after arguments parsing. It works in my case, 
 
-- 
Regards,
Yury Krivopalov
------==--bound.97459.web15m.yandex.ru
Content-Disposition: attachment;
	filename="drop_back_slash_after_parsing.patch"
Content-Transfer-Encoding: base64
Content-Type: text/x-diff;
	name="drop_back_slash_after_parsing.patch"

LS0tIG1vZHVsZXMvcGFyc2Vfc3VuLmMub3JpZwkyMDE2LTA2LTMwIDEyOjI1OjI0LjMwMzE3MTQw
NSArMDMwMAorKysgbW9kdWxlcy9wYXJzZV9zdW4uYwkyMDE2LTA2LTMwIDEyOjI3OjE3LjI2OTgz
MzE1MSArMDMwMApAQCAtMTc3LDEzICsxNzcsMTAgQEAKIAkJCX0KIAkJCWJyZWFrOwogCiAJCWNh
c2UgJ1xcJzoKIAkJCWxlbisrOwotCQkJaWYgKGRzdCkKLQkJCQkqZHN0KysgPSBjaDsKLQogCQkJ
aWYgKCpzcmMpIHsKIAkJCQlsZW4rKzsKIAkJCQlpZiAoZHN0KQogCQkJCQkqZHN0KysgPSAqc3Jj
OwogCQkJCXNyYysrOwo=
------==--bound.97459.web15m.yandex.ru--
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
