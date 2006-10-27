From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: automounted filesystems being unmounted and
	mounted	every minute
Date: Fri, 27 Oct 2006 19:04:38 -0400
Message-ID: <x49fyd9nywp.fsf@segfault.boston.devel.redhat.com>
References: <0F5A1C742BC73849AFF518F1F8249D4D0181D362@mtpx3m2.mtp.emea.dell.com>
	<1161962982.11403.7.camel@pc.ilinx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1161962982.11403.7.camel@pc.ilinx> (Brian J. Murrell's message
	of "Fri, 27 Oct 2006 11:29:42 -0400")
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
Cc: autofs@linux.kernel.org, Scott_Rochford@DELL.com

==> Regarding Re: [autofs] automounted filesystems being unmounted and mounted every minute; "Brian J. Murrell" <brian@interlinx.bc.ca> adds:

brian> On Fri, 2006-27-10 at 16:14 +0100, Scott_Rochford@DELL.com wrote:
>> Hi,

brian> Hello,

>> I've been puzzling over a similar problem with mounts of long since
>> removed users' home directories occurring every few minutes for some
>> time and was thrilled to discover this thread on the subject, however
>> after enabling debugging as instructed I only get:
>> 
>> Oct 27 16:06:04 e1shdb03 automount[16563]: handle_packet: type = 0 Oct
>> 27 16:06:04 e1shdb03 automount[16563]: handle_packet_missing: token
>> 1487772, name scott Oct 27 16:06:04 e1shdb03 automount[16563]:
>> attempting to mount entry /users/scott
>> 
>> RHEL AS 3 autofs-4.1.3-154 2.4.21-37.0.1.ELhugemem
>> 
>> Do you have any other suggestions for methods to identify the processes
>> that are triggering these mount attempts?

brian> The instructions at http://people.redhat.com/jmoyer were very
brian> helpful on my Mandriva boxes as it would print the pid.  On my
brian> Ubuntu Edgy box though no pids to be found.  :-(

brian> In my case I found two causes:

brian>      1. Having an automounted share in my GTK "bookmarks" was
brian> causing a ping-pong effect where as soon as it was unmounted,
brian> gnome-panel wanted to go stat it.  Stupid.  2. An open Nautilus
brian> window and/or a Nautilus desktop icon on/for an automounted share
brian> was causing the same kind of ping pong.

The new autofs kernel code logs pid information of the requester.  Older
code bases do not.

-Jeff
