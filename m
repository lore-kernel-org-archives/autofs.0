From: Andreas Reis <andreas.reis@gmail.com>
Subject: NFSv4: Unable to mount, nonsensical error
Date: Sat, 27 Sep 2014 16:27:15 +0200
Message-ID: <5426C943.1060307@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=J6efdIsVzVYMY6fjxe21dSBsKJw37b/2EOZAH6FITB8=;
        b=QWla0uF0y5WIXeJ9SDXcaWOP27e0s1a5aliTx68y5Puzgt6FQcECzWYszPUs1GILHT
         KgV5tvuF9fl193Ys/JGMwOVV4eDf1Y12tTZa0h0R4hvDJ19QnIh1Sbe5HhWMcnjmxvHx
         bA5jnw1Cm/TPFndd9sQKjV9JokZIxCpCbfgR7g5AXXAGUkctxVtiOGS4E/gPO1jkDWAk
         LnLx25RY4HMvDxkZkROboHrepkABQYopNcQNeglctysrh12ms0b8JbOd715Q6l8rnm9i
         QJA/jFyXQuklersLupaIs8H9XfJ5EO3hjZAn9LlTZvSjXyM/AFh+oipVxp5DkFeK2hw/
         7HXQ==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: autofs@vger.kernel.org

Hi,

I'm trying to automount a NFSv4 share to /mnt/bar from Host A via a=20
direct map, but can't get it to work no matter what.

Mounting it manually with the very same options works perfectly fine.

auto.master:
/-     /etc/autofs/bar.nfs    --timeout=3D15 --ghost
/foo   /etc/autofs/auto.nfs   --timeout=3D15

The second line is an executable map for NFSv3 shares from Host B. That=
=20
one works as intended. However=E2=80=A6

fs.nfs:
/mnt/bar -fstype=3Dnfs4,rw,soft,async,_netdev,rsize=3D8192,wsize=3D8192=
=20
192.168.1.144:bar
(on one line)

=E2=80=A6 fails. Instead, the folder is still created, but accessing it=
 yields=20
"No such file or directory".

Meanwhile automount prints a nonsensical =E2=80=A6

"validate_location: expected colon delimeter not found in location=20
192.168.1.144:bar"

=E2=80=A6 which from an error path (with a typo) in parse_sun.c's=20
validate_location that was added in autofs 5.0.6.

Maybe the person who added it missed that unlike mount requests for=20
NFSv3 shares, NFSv4 ones need not (depending on the server, must not)=20
have a "/" after the ":"?

Because that however is what the somewhat misleadingly named check_colo=
n=20
function called by validate_location checks.

Nonetheless, patching that path to still return 1 resolved nothing.

Any ideas?

(Distro is Arch, updated packages, ie. autofs 5.1.0.)

Thanks,
Andreas
