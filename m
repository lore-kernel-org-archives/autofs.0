From: Frank Thommen <list.autofs@drosera.ch>
Subject: autofs-5.0.7-56 on RHEL/CentOS: auto.master documentation (or me)
 wrong?
Date: Mon, 15 Jan 2018 18:32:41 +0100
Message-ID: <203f8953-f038-a787-8006-8e72f90b7326@drosera.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@vger.kernel.org

Dear all,

in the auto.master manpage (CentOS 7.3.1611, autofs-5.0.7-56) it says:

---------
[...]
        options
               Any remaining command line arguments without leading 
dashes (-) are taken as options (-o) to mount.  Arguments with leading 
dashes are considered options for the maps and are passed to automount (8).

               The sun format supports the following options:

[...]
---------

However a line like

   /home   /etc/auto.home   browse vers=4.0

or

   /home   /etc/auto.home   browse,vers=4.0


results in the following error messages when running autofs with 
debugging enabled:

[...]
Jan 15 17:46:47 tbi-cn010 automount[26585]: syntax error while parsing map.
Jan 15 17:46:47 tbi-cn010 automount[26585]: syntax error in map near [ 
bogus option ]
[...]


Instead the option seems to have to be added to the indirect map 
/etc/auto.home

   * -vers=4.0 server:/exports/home/&


Do I misunderstand the documentation or is it wrong?

Additionally I'm missing the manpage containing the format description 
of the indirect maps.  AFAIR this used to be part of the "autofs" or 
"automount" manpage.


Cheers
frank


--
To unsubscribe from this list: send the line "unsubscribe autofs" in
