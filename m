From: Greg Bradner <gregb@rhythm.com>
Subject: Re: making the mountpoints visible all the time
Date: Fri, 14 Nov 2003 07:13:16 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FB4F10C.5080201@rhythm.com>
References: <Pine.LNX.4.33.0311141100050.30495-100000@wombat.indigo.net.au>
	<3FB4C6CF.7030100@yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3FB4C6CF.7030100@yahoo.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Alexander Macdonald <alexandermacdonald@yahoo.com>
Cc: autofs@linux.kernel.org

If you look in the samples directory, a file map is the auto.misc map.

 > cat auto.master
# $Id: auto.master,v 1.2 1997/10/06 21:52:03 hpa Exp $
# Sample auto.master file
# Format of this file:
# mountpoint map options
# For details of the format look at autofs(8).
/misc   /etc/auto.misc
/net    /etc/auto.net

 > cat auto.misc
# $Id: auto.misc,v 1.2 1997/10/06 21:52:04 hpa Exp $
# This is an automounter map and it has the following format
# key [ -mount-options-separated-by-comma ] location
# Details may be found in the autofs(5) manpage

kernel          -ro                     ftp.kernel.org:/pub/linux
boot            -fstype=ext2            :/dev/hda1
removable       -fstype=ext2            :/dev/hdd
cd              -fstype=iso9660,ro      :/dev/hdc
floppy          -fstype=auto            :/dev/fd0


Alexander Macdonald wrote:

> Ian Kent wrote:
>
>> The autofs4-2.4 module build kit or the patches contained in it or the
>> patches contained in autofs-4.1.0-beta3 can give you this for some of 
>> the
>> maps. NIS, LDAP and file maps work at the moment.
>>
>> I's in the expected place on kernel.org.
>>  
>>
>
> not sure what you mean by file maps, but I'm trying to mount samba and 
> nfs shares so i guess I'm out of luck...
>
>
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs


-- 

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Rhythm & Hues
5404 Jandy Place
Los Angeles, CA 90066
Voice: 310 448-7763
Fax:   310 448-7600
gregb@rhythm.com
