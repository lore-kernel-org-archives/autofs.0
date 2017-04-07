From: Mark Fox <mfox@customdatacentre.com>
Subject: Changes to special character escaping?
Date: Fri, 7 Apr 2017 16:56:34 -0600
Message-ID: <CAFVxx_NaVK6J=tvfCa7AUQDaGLPE0ipZjpcqc1N55N4KrY5kKA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org

Has something changed regarding escaping of special characters? The
methods used to deal with special characters in maps that are included
in distributions (ie. Ubuntu 16.04.2, so automount 5.1.1) no longer
seem to work.

Without special characters, autofs works wonderfully on all sorts of
CIFS shares. However, with a CIFS administrative share (C$), or a
share with an ampersand, I've had no luck. The shares work fine
through smbclient or when mounted by hand, but I haven't stumbled onto
how to get it working under autofs.

My problem setup is simple:

--- /etc/auto.master ---
+auto.master
/cifs /etc/auto.cifs --timeout=300 --ghost
------

--- /etc/auto.cifs ---
CDC1 -fstype=cifs,rw,noperm,credentials=/etc/creds/CDC1 \
     "/C$" "://CDC1/C\$"
------

It doesn't work as configured above. The output from 'automount -f -v' is:

------
attempting to mount entry /cifs/CDC1/C$
>> Retrying with upper case share name
>> mount error(6): No such device or address
>> Refer to the mount.cifs(8) manual page (e.g. man mount.cifs)
mount(generic): failed to mount //CDC1/C\$ (type cifs) on /cifs/CDC1/C$
failed to mount /cifs/CDC1/C$
------

If the escaping of '$' is removed from auto.cifs, the last two lines
of output change to:

------
mount(generic): failed to mount //CDC1/C (type cifs) on /cifs/CDC1/C$
failed to mount /cifs/CDC1/C$
------

More slashes don't help.

What is the correct way, if any, to escape a special character in the
situation I've outlined?

This problem aside, autofs has allowed us to greatly simplify the
interaction between our backup system and Windows servers. A heartfelt
thank-you to everyone involved.


Mark
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
