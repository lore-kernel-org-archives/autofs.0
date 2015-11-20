From: Ken Gillett <KenGroups@ukgb.net>
Subject: space(s) in key or location names
Date: Fri, 20 Nov 2015 09:42:34 +0000
Message-ID: <B75A85DC-1A7A-475F-AE15-7FBF60FCE936@ukgb.net>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <autofs-owner@vger.kernel.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: autofs@vger.kernel.org

I=E2=80=99m really struggling with this and hope someone can point me t=
o a solution.

I need to automount onto a mountpoint (directory, i.e. folder as it=E2=80=
=99s on OS X) that has a space in the name and I cannot change that. I=E2=
=80=99ve read many suggestions to escape the space with a =E2=80=98\=E2=
=80=99 or =E2=80=98\040=E2=80=99 or quote the path, but nothing I=E2=80=
=99ve tried works. It either simply fails to work or creates the mountp=
oint that includes the escape chars in its name.

To clarify, other mounts that have no space involved work fine, so the =
basic setup is sound and if the automount is configured in a local (LDA=
P) directory, the space is no problem. However, I don=E2=80=99t want to=
 use that method and really need to use simple map files in /etc, but t=
here seems to be this issue with how they are parsed. I am clearly not =
the only person with this problem.

I=E2=80=99d really appreciate it if someone could explain how to overco=
me this and allow for spaces in pathnames used in map files.



Ken  G i l l e t t

_/_/_/_/_/_/_/_/




--
To unsubscribe from this list: send the line "unsubscribe autofs" in
