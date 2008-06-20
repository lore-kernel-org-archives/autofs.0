From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Horrible denial of service bug in autmount 5
Date: Fri, 20 Jun 2008 12:03:28 -0700
Message-ID: <485BFF00.7020205@zytor.com>
References: <8332BEF1-7FA5-434F-B444-9F8820A61B83@cam.ac.uk>	
	<1213969464.2971.107.camel@raven.themaw.net>	
	<5A1DEB9E-FD94-455E-AB89-05D9E74084B5@cam.ac.uk>	
	<1213974299.4975.15.camel@raven.themaw.net>	
	<095037D1-F2F1-4A08-A6D2-841C22D8BC5C@cam.ac.uk>	
	<1213975734.4975.17.camel@raven.themaw.net>
	<485BE2E6.9080509@zytor.com>
	<1213986137.4975.39.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1213986137.4975.39.camel@raven.themaw.net>
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
Cc: autofs@linux.kernel.org, Anton Altaparmakov <aia21@cam.ac.uk>, Unix Support <unix-support@ucs.cam.ac.uk>

Ian Kent wrote:
>> Okay, I'm confused... what reason could there *possibly* be for 
>> searching /proc/*/cmdline? If there is a need for a mutex of some sort, 
>> one should typically create a /var/run directory and put in lock files, 
>> or some other solution to test the mutexing explicitly.  grepping ps, in 
>> effect, is hardly a good idea, to put it gently.
> 
> This is nothing more than a check to see if another instance of
> automount(8) is running.

But it is an utterly daft way to implement something like that.  If you 
want a lock, create an explicit lock, but doing string-matching on 
command lines is idiotic.

	-hpa
