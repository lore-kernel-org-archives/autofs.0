From: Ian Kent <raven@themaw.net>
Subject: Re: unable to automount windows C$
Date: Tue, 12 May 2009 12:45:26 +0800
Message-ID: <4A08FEE6.7000604@themaw.net>
References: <9728fb580812101149s300c524dn5f6785c16bac969c@mail.gmail.com>
	<1230012791.3043.6.camel@zeus.themaw.net>
	<4A07749D.4000406@edcint.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4A07749D.4000406@edcint.co.nz>
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
To: Matthew Jurgens <autofs@edcint.co.nz>
Cc: autofs@linux.kernel.org, Scott Belnap <sbelnap@gmail.com>

Matthew Jurgens wrote:
> I've had this same problem from time to time and since upgrading to
> Fedora 10 it has come back:
> Fedora 10 - kernel 2.6.27.21-170.2.56.fc10.i686.PAE
> autofs-5.0.3-41.i386
> 
> The correctly mounted manual entry:
> //xp0/C$ on /mnt type cifs (rw,mand)
> 
> The autofs entry:
> //xp0/C/$ on /smb/xp0/C$ type cifs (rw,mand)
> 
> If you need anymore debug info let me know

I have no idea what you are trying to say.
The above, //xp0/C/$, doesn't correspond to what autofs-5.0.3-41 passes
to mount(8) and I have no idea what has happened since you haven't
provided any log information.

> 
> Ian Kent wrote:
>> On Wed, 2008-12-10 at 12:49 -0700, Scott Belnap wrote:
>>  
>>> I'm trying to automount a windows machine.  I am able to automount any
>>> directory that doesn't have a $ in the mount name.  Looks like the
>>> parse_mount method is stripping out the $ from the mount name.  Any
>>> ideas on how to fix this?
>>>     
>>
>> I think you might need to escape the $ that gets clobbered. It is most
>> likely getting interpreted as a dollar macro expansion.
>>
>>  
>>> Dec  9 23:49:03 dc2 automount[19084]: handle_packet_missing_direct:
>>> token 122, name /cifs/laptop/C$, request pid 17857
>>> Dec  9 23:49:03 dc2 automount[19084]: attempting to mount
>>> entry /cifs/laptop/C$
>>> Dec  9 23:49:03 dc2 automount[19084]: lookup_mount:
>>> lookup(program): /cifs/laptop/C$ ->
>>> -fstype=cifs,file_mode=0644,dir_mode=0755,credentials=/etc/auto.smb.laptop
>>> ://laptop/C$
>>> Dec  9 23:49:03 dc2 automount[19084]: parse_mount: parse(sun):
>>> expanded entry:
>>> -fstype=cifs,file_mode=0644,dir_mode=0755,credentials=/etc/auto.smb.laptop
>>> ://laptop/C
>>> Dec  9 23:49:03 dc2 automount[19084]: parse_mount: parse(sun):
>>> gathered options:
>>> fstype=cifs,file_mode=0644,dir_mode=0755,credentials=/etc/auto.smb.laptop
>>>
>>> Dec  9 23:49:03 dc2 automount[19084]: parse_mount: parse(sun): core of
>>> entry:
>>> options=fstype=cifs,file_mode=0644,dir_mode=0755,credentials=/etc/auto.smb.laptop,
>>> loc=://laptop/C
>>> Dec  9 23:49:03 dc2 automount[19084]: sun_mount: parse(sun): mounting
>>> root /cifs, mountpoint /cifs/laptop/C$, what //laptop/C, fstype cifs,
>>> options file_mode=0644,dir_mode=0755,credentials=/etc/auto.smb.laptop
>>> Dec  9 23:49:03 dc2 automount[19084]:
>>> do_mount: //laptop/C /cifs//cifs/laptop/C$ type cifs options
>>> file_mode=0644,dir_mode=0755,credentials=/etc/auto.smb.laptop using
>>> module generic
>>> Dec  9 23:49:03 dc2 automount[19084]: mount_mount: mount(generic):
>>> calling mkdir_path /cifs/laptop/C$
>>> Dec  9 23:49:03 dc2 automount[19084]: mount_mount: mount(generic):
>>> calling mount -t cifs -s -o
>>> file_mode=0644,dir_mode=0755,credentials=/etc/auto.smb.laptop
>>> //laptop/C /cifs/laptop/C$
>>> Dec  9 23:49:03 dc2 kernel:  CIFS VFS: cifs_mount failed w/return code
>>> = -6
>>> Dec  9 23:49:03 dc2 automount[19084]: >> retrying with upper case
>>> share name
>>> Dec  9 23:49:03 dc2 kernel:  CIFS VFS: cifs_mount failed w/return code
>>> = -6
>>> Dec  9 23:49:03 dc2 automount[19084]: >> mount error 6 = No such
>>> device or address
>>> Dec  9 23:49:03 dc2 automount[19084]: >> Refer to the mount.cifs(8)
>>> manual page (e.g.man mount.cifs)
>>> Dec  9 23:49:03 dc2 automount[19084]: spawn_mount: mount failed with
>>> error code 16, retrying with the -f option
>>> Dec  9 23:49:06 dc2 automount[19084]: >> unknown mount option f
>>> Dec  9 23:49:06 dc2 automount[19084]: >> Usage:  /sbin/mount.cifs
>>> <remotetarget> <dir> -o <options>
>>> Dec  9 23:49:06 dc2 automount[19084]: >> Mount the remote target,
>>> specified as a UNC name, to a local directory.
>>> Dec  9 23:49:06 dc2 automount[19084]: >> Options:
>>> Dec  9 23:49:06 dc2 automount[19084]: >> #011user=<arg>
>>> Dec  9 23:49:06 dc2 automount[19084]: >> #011pass=<arg>
>>> Dec  9 23:49:06 dc2 automount[19084]: >> #011dom=<arg>
>>> Dec  9 23:49:06 dc2 automount[19084]: >> Less commonly used options:
>>> Dec  9 23:49:06 dc2 automount[19084]: >>
>>> #011credentials=<filename>,guest,perm,noperm,setuids,nosetuids,rw,ro,
>>> Dec  9 23:49:06 dc2 automount[19084]: >>
>>> #011sep=<char>,iocharset=<codepage>,suid,nosuid,exec,noexec,serverino,
>>> Dec  9 23:49:06 dc2 automount[19084]: >>
>>> #011directio,mapchars,nomapchars,nolock,servernetbiosname=<SRV_RFC1001NAME>
>>>
>>> Dec  9 23:49:06 dc2 automount[19084]: >> Options not needed for
>>> servers supporting CIFS Unix extensions
>>> Dec  9 23:49:06 dc2 automount[19084]: >> #011(e.g. unneeded for mounts
>>> to most Samba versions):
>>> Dec  9 23:49:06 dc2 automount[19084]: >>
>>> #011uid=<uid>,gid=<gid>,dir_mode=<mode>,file_mode=<mode>,sfu
>>> Dec  9 23:49:06 dc2 automount[19084]: >> Rarely used options:
>>> Dec  9 23:49:06 dc2 automount[19084]: >>
>>> #011port=<tcpport>,rsize=<size>,wsize=<size>,unc=<unc_name>,ip=<ip_address>,
>>>
>>> Dec  9 23:49:06 dc2 automount[19084]: >>
>>> #011dev,nodev,nouser_xattr,netbiosname=<OUR_RFC1001NAME>,hard,soft,intr,
>>> Dec  9 23:49:06 dc2 automount[19084]: >>
>>> #011nointr,ignorecase,noposixpaths,noacl
>>> Dec  9 23:49:06 dc2 automount[19084]: >> Options are described in more
>>> detail in the manual page
>>> Dec  9 23:49:06 dc2 automount[19084]: >> #011man 8 mount.cifs
>>> Dec  9 23:49:06 dc2 automount[19084]: >> To display the version number
>>> of the mount helper:
>>> Dec  9 23:49:06 dc2 automount[19084]: >> #011/sbin/mount.cifs -V
>>> Dec  9 23:49:06 dc2 automount[19084]: mount(generic): failed to
>>> mount //laptop/C (type cifs) on /cifs/laptop/C$
>>> Dec  9 23:49:06 dc2 automount[19084]: send_fail: token = 122
>>> Dec  9 23:49:06 dc2 automount[19084]: handle_packet: type = 5
>>> Dec  9 23:49:06 dc2 automount[19084]: handle_packet_missing_direct:
>>> token 123, name /cifs/laptop/C$, request pid 17857
>>> Dec  9 23:49:06 dc2 automount[19084]: attempting to mount
>>> entry /cifs/laptop/C$
>>> Dec  9 23:49:06 dc2 automount[19084]: failed to mount /cifs/laptop/C$
>>> Dec  9 23:49:06 dc2 automount[19084]: send_fail: token = 123
>>> Dec  9 23:49:06 dc2 automount[19084]: failed to mount /cifs/laptop/C$
>>>
>>> _______________________________________________
>>> autofs mailing list
>>> autofs@linux.kernel.org
>>> http://linux.kernel.org/mailman/listinfo/autofs
>>>     
>>
>> _______________________________________________
>> autofs mailing list
>> autofs@linux.kernel.org
>> http://linux.kernel.org/mailman/listinfo/autofs
>>
>>   
> 
