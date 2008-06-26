From: "Stephen Biggs" <sbiggs@nvidia.com>
Subject: Re: Direct mount newbie question
Date: Thu, 26 Jun 2008 11:35:58 -0700
Message-ID: <A2ECBF49F352C24F9DF65BB529DCBC70187A5798@hqemmail01.nvidia.com>
References: <A2ECBF49F352C24F9DF65BB529DCBC70187A578E@hqemmail01.nvidia.com>
	<1214451597.12623.276.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1214451597.12623.276.camel@raven.themaw.net>
Content-class: urn:content-classes:message
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

> -----Original Message-----
> From: Ian Kent [mailto:raven@themaw.net] 
> Sent: Wednesday, June 25, 2008 8:40 PM
> To: Stephen Biggs
> Cc: autofs@linux.kernel.org
> Subject: Re: [autofs] Direct mount newbie question
> 

--snip--

> 
> What about having an entry in the indirect map with a key 
> .junk that mounts a temporary local mount instead of an 
> actual direct mount?

Yes, this did the trick for us.  I was a bit leery of changing the
system-wide map file, but this seems to work seamlessly and it fits
within the indirect mount structure we have without throwing direct
automounts into the mix.  Thanks, Ian!

--snip--

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
