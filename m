From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Please help - cleanup
Date: Thu, 6 May 2004 08:40:16 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16538.12848.197215.483456@segfault.boston.redhat.com>
References: <Pine.LNX.4.58.0405022201480.25614@donald.themaw.net>
	<Pine.LNX.4.58.0405042233560.17014@donald.themaw.net>
	<16535.44980.475389.900686@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0405042308070.17014@donald.themaw.net>
	<16537.26586.135188.997029@segfault.boston.redhat.com>
	<40997CA1.2070904@sedona.intel.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <40997CA1.2070904@sedona.intel.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Michael Blandford <mlblandf@sedona.ch.intel.com>
Cc: autofs mailing list <autofs@linux.kernel.org>

==> Regarding Re: [autofs] Please help - cleanup; Michael Blandford <mlblandf@sedona.ch.intel.com> adds:

mlblandf> Jeff Moyer wrote:
>> ==> Regarding Re: [autofs] Please help - cleanup; raven@themaw.net adds:
>> 
>> [snip]
raven> If anyone is able to test this also that would be great.
>>
>>>> I will roll another test rpm with this patch and post to my people
>>>> page.
>>>> 
>>>> 
>> Has anyone had the chance to test this?  autofs-4.1.2-5 from my people
>> page, or the patch Ian sent to the list?  I'd like to hear feedback,
>> either positive or negative as I have to push a package into FC2 before
>> the freeze on Friday.
>> 
>> 
>> 

mlblandf> I have not had a chance to play with it extensively.  I will
mlblandf> dedicate time to it tomorrow.

mlblandf> Just a couple of questions

mlblandf> 1) What about the get-best-mount.patch?  My impression was it
mlblandf> wasn't needed with the new replicated server patch.

I'm not certain of this, as I haven't had a chance to test w/o it.  As I
mentioned before, I ran across a problem with clients that got their maps
from LDAP.  They would timeout given the low timeout value passed to
rpc_ping.  If we just tell it to use a long timeout value, this seems to
work.  As I mentioned, this is a band-aid, and I haven't debugged the real
problem.  I'm hoping Ian's patches fix it.

mlblandf> 2) What kernel modules are you going to add to the kernel?  Is it
mlblandf> the 20040417 ( for 2.6 ) or are you going to wait for the newest
mlblandf> ones from Ian?

Unfortunately, the kernel is frozen.  I will have to wait until the pool
opens up again before I can get any changes in.  In general, we don't take
patches that aren't upstream, so it's important that the changes make it
into the Linus tree.

mlblandf> 3) Are you going to add your yp patch to your rpm?

That will be present in the version I build into FC2.  It is not present in
4.1.2-5.

-Jeff
