From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: automounted filesystems being unmounted and
	mounted	every minute
Date: Mon, 16 Oct 2006 14:08:27 -0400
Message-ID: <x49d58sxhes.fsf@segfault.boston.devel.redhat.com>
References: <1161005417.3184.5.camel@pc.ilinx>
	<1161016376.3085.86.camel@localhost>
	<1161019573.3184.15.camel@pc.ilinx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1161019573.3184.15.camel@pc.ilinx> (Brian J. Murrell's message
	of "Mon, 16 Oct 2006 13:26:13 -0400")
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
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
Cc: autofs@linux.kernel.org

==> Regarding Re: [autofs] automounted filesystems being unmounted and mounted every minute; "Brian J. Murrell" <brian@interlinx.bc.ca> adds:

brian> On Tue, 2006-17-10 at 00:32 +0800, Ian Kent wrote:
>> On Mon, 2006-10-16 at 09:30 -0400, Brian J. Murrell wrote: > Autofs
>> 5.0.1 seems to be doing an unmount/mount of my home dir > filesystems
>> every minute or so.  Verbose output from autofs shows:
>> > 
>> > Oct 16 09:27:23 jenny automount[18632]: expiring path /autohome/share
>> > Oct 16 09:27:23 jenny automount[18632]: unmounting dir =
>> /autohome/share > Oct 16 09:27:23 jenny automount[18632]: expired
>> /autohome/share > Oct 16 09:27:23 jenny automount[18632]: expiring path
>> /autohome/brian > Oct 16 09:27:23 jenny automount[18632]: unmounting dir
>> = /autohome/brian > Oct 16 09:27:23 jenny automount[18632]: expired
>> /autohome/brian > Oct 16 09:27:24 jenny automount[18632]: attempting to
>> mount entry /autohome/share > Oct 16 09:27:24 jenny automount[18632]:
>> mount(nfs): mounted linux:/home/share on /autohome/share > Oct 16
>> 09:27:24 jenny automount[18632]: mounted /autohome/share > Oct 16
>> 09:27:24 jenny automount[18632]: mount still busy /autohome
>> > 
>> > Why is it in the same window of operation expiring, unmounting and >
>> remounting filesystems?
>> 
>> Is the directory busy?  That is is it the pwd of some process or have
>> open files?

brian> Don't think so:

brian> $ sudo ls -l /proc/*/cwd | grep share [nothing]

>> If it's not then it will be umounted when it times out, after 1 minute
>> in this case. Then if some smart application scans directory trees when
>> it sees mount or umount activity then it will be mounted again. We've
>> seen this with older versions of hald.

brian> Heh.

>> The best way to find out what is causing this is to enable debug logging

brian> As in "automount -d"?

>> on a test machine and check what pid is causing mount activity.

brian> I tried this (automount -d) but am not seeing any more information
brian> than -v provides.

Take a look at http://people.redhat.com/jmoyer for documentation on how to
gather debug information from the automounter.  Basically, you need to log
daemon.* somewhere.

-Jeff
