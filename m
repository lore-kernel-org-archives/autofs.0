From: Michael Blandford <mlblandf@sedona.ch.intel.com>
Subject: Re: Please help - cleanup
Date: Wed, 05 May 2004 16:45:37 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40997CA1.2070904@sedona.intel.com>
References: <Pine.LNX.4.58.0405022201480.25614@donald.themaw.net>
	<Pine.LNX.4.58.0405042233560.17014@donald.themaw.net>
	<16535.44980.475389.900686@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0405042308070.17014@donald.themaw.net>
	<16537.26586.135188.997029@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16537.26586.135188.997029@segfault.boston.redhat.com>
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
To: jmoyer@redhat.com
Cc: autofs mailing list <autofs@linux.kernel.org>

Jeff Moyer wrote:

>==> Regarding Re: [autofs] Please help - cleanup; raven@themaw.net adds:
>
>[snip]
>raven> If anyone is able to test this also that would be great.
>  
>
>>>I will roll another test rpm with this patch and post to my people page.
>>>      
>>>
>
>Has anyone had the chance to test this?  autofs-4.1.2-5 from my people
>page, or the patch Ian sent to the list?  I'd like to hear feedback, either
>positive or negative as I have to push a package into FC2 before the
>freeze on Friday.
>
>  
>

I have not had a chance to play with it extensively.  I will dedicate 
time to it tomorrow.

Just a couple of questions

1) What about the get-best-mount.patch?  My impression was it wasn't 
needed with the new replicated server patch. 

2) What kernel modules are you going to add to the kernel?  Is it the 
20040417 ( for 2.6 ) or are you going to wait for the newest ones from Ian?

3) Are you going to add your yp patch to your rpm?

Michael


Disclaimer: The content of this message is my personal opinion only and 
although I am an employee of Intel, the statements I make here in no way 
represent Intel's position on the issue, nor am I authorized to speak on 
behalf of Intel on this matter.
