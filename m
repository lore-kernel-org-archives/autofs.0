From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Autofs4 4.1.3-28 with NetApp filer
Date: Tue, 22 Feb 2005 11:57:01 -0500
Message-ID: <16923.25693.299614.639181@segfault.boston.redhat.com>
References: <482A3FA0050D21419C269D13989C611308539786@lavender-fe.eng.netapp.com>
	<Pine.LNX.4.58.0502211259250.9892@wombat.indigo.net.au>
	<16922.2764.932856.525189@segfault.boston.redhat.com>
	<Pine.LNX.4.61.0502220033460.20458@donald.themaw.net>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.61.0502220033460.20458@donald.themaw.net>
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
Content-Type: text/plain; charset="us-ascii"
To: raven@themaw.net
Cc: autofs@linux.kernel.org, "Lever, Charles" <Charles.Lever@netapp.com>

==> Regarding Re: [autofs] Autofs4 4.1.3-28 with NetApp filer; raven@themaw.net adds:

raven> On Mon, 21 Feb 2005, Jeff Moyer wrote:
>> ==> Regarding Re: [autofs] Autofs4 4.1.3-28 with NetApp filer; Ian Kent
>> <raven@themaw.net> adds:
>> 
raven> On Sun, 20 Feb 2005, Lever, Charles wrote:
>>>> Customer of ours describes this problem:
>>>> 
>>>>> We have several netapp boxes that we use as filers and all > of them
>>>> at this site, with the exception of this one box, would unmount > for
>>>> the linux workstation after the autmount timeout period.  With the >
>>>> implementation of autofs-4.1.3-28 this particular netapp box would not
>>>> > only NOT unmount (/net mounts) after timeouts, and would not release
>>>> > its ports, it would begin to actively take more ports (without any >
>>>> other mounts of this netapp box taking place).  Within 24 hours a
>>>> linux
>>>>> box can be hung by the port-taking activity of this netapp box
>>>>> mounted via /net.
>>>> They are running on RH 8.0, kernel 2.4.20-20.8smp.  Problem did not
>>>> occur with autofs-4.1.2.
>>>> 
>>>> Does this sound familiar to anyone?
>>
raven> This sounds like the mount order problem we had recently.  Also
raven> against a Filer I think.
>>
raven> We can confirm this is the same problem by collecting a log with the
raven> --debug option set.
>>
raven> I can forward a patch but Jeff may already have included it in his
raven> rpm.
>>
raven> Lets confirm it first.
>> Maybe it's just because it's Monday, but I'm not sure which patch you
>> are referring to.  Could you post it, and then I'll let you know if I
>> have an updated RPM?  ;-)
>> 

raven> Sure thing. The patch forces the mount order to be shortest path to
raven> longest regardless of the order the export list.

raven> There were two patches.  The second being a correction.

Thanks for reposting, Ian.  These slipped through the cracks.  I'll get
them into our version of the package.

Thanks!

Jeff
