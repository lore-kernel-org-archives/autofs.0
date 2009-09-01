From: Ian Kent <raven@themaw.net>
Subject: Re: More CIFS $ Share Woes
Date: Tue, 01 Sep 2009 10:46:25 +0800
Message-ID: <4A9C8B01.9060708@themaw.net>
References: <85c7eb2d0908280709u35cd5cfci7f50413da61539e7@mail.gmail.com>	
	<4A9B5274.4040800@themaw.net>	
	<85c7eb2d0908310522u18907b17pd1399a1cf79ad1e5@mail.gmail.com>
	<85c7eb2d0908311255j5b457221ld88131f111611f04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <85c7eb2d0908311255j5b457221ld88131f111611f04@mail.gmail.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: "Jason T. Masker" <jason.fmic@masker.net>
Cc: autofs@linux.kernel.org

Jason T. Masker wrote:
> I also tried changing the print line to the following:
> 
> print " \\\n\t \"/" dir "\"", "://" key "/" lo
> 
> 
> 
> so that the output looks like this:
> 
> $ sudo /etc/auto.cifs VMW1013
> -fstype=cifs,file_mode=0644,dir_mode=0755,uid=jmasker,gid=users,credentials=/etc/auto.smb.jmasker
> \
>          "/My Documents" ://VMW1013/My Documents \
>          "/ADMIN$" ://VMW1013/ADMIN\$ \
>          "/C$" ://VMW1013/C\$ \
>          "/Shared" ://VMW1013/Shared
> 
> 
> However, this results in automount dropping the $ as well.  The debug
> looks identical to what I just posted.

Yes, the location does need to double escape the dollar in the mount.
The double quotes are meant to preserve any spaces present in the
location but the "$" is also used as a macro introducer so it needs to
be escaped a second time so it doesn't get substituted with NULL when
the entry is expanded. What makes this difficult is the "\" is also a
separator and gets translated to "/" by mount.cifs. When you run the
mount from the command line the shell translates the "\$" to "$" before
it gets to mount.cifs.

I think the problem occurs because, when the entry is initially broken
up into mount triggers for each share and each is mounted, expanding the
map entry needs to preserve the "\$", but when the individual triggers
are walked on expanding the entry needs to substitute the "\$" for "$"
so the mount works. The problem being that the expand subroutine doesn't
know the difference between these two invocations.

I'll have a look and see.

Ian
