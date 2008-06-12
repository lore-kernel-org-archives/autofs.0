From: Lukas Kolbe <lukas@einfachkaffee.de>
Subject: autofs 5.0.2 (and 5.0.3) keep segfaulting
Date: Thu, 12 Jun 2008 13:07:10 +0200
Message-ID: <1213268830.10126.8.camel@vesuv.TechFak.Uni-Bielefeld.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

Hi List,

about twice a day, autofs keeps segfaulting on our main mailhub:

Jun 12 12:53:38 mailin automount[12008]: parse_mount: parse(sun): expanded entry: :/users/stud01/stud/juser
Jun 12 12:53:38 mailin automount[12008]: parse_mount: parse(sun): gathered options: 
Jun 12 12:53:38 mailin automount[12008]: parse_mount: parse(sun): dequote(":/users/stud01/stud/juser") -> :/users/stud01/stud/juser
Jun 12 12:53:38 mailin automount[12008]: parse_mount: parse(sun): core of entry: options=, loc=:/users/stud01/stud/juser
Jun 12 12:53:38 mailin automount[12008]: sun_mount: parse(sun): mounting root /homes, mountpoint juser, what :/users/stud01/stud/juser, fstype nfs, options (null)
Jun 12 12:53:38 mailin automount[12008]: mount_mount: mount(nfs): root=/homes name=juser what=:/users/stud01/stud/juser, fstype=nfs, options=(null)
Jun 12 12:53:38 mailin automount[12008]: mount_mount: mount(nfs): calling mkdir_path /homes/juser
Jun 12 12:53:38 mailin automount[12008]: mount_mount: mount(nfs): juser is local, attempt bind mount
Jun 12 12:53:38 mailin kernel: automount[15542]: segfault at 0000000000000020 rip 00002aaaaadff7ff rsp 0000000040421350 error 4

This happend after we upgraded from version 5.0.1 to 5.0.3, and also
happens with 5.0.2 (with all patches from kernel.org as of June 10
applied, as specified in patch_order-5.0.2 and patch_order-5.0.3).

I have a core dump that I could provide privately. This didn't happen
with 5.0.1. 

The system is a Debian Etch, kernel 2.6.18-6-xen from debian. 
Any hints on what I can try, e.g. the patches Ian sent earlier today to
the list?

-- 
Lukas
