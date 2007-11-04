From: Ian Kent <raven@themaw.net>
Subject: Re: ENOENT on first reference to an automounted file
Date: Sun, 04 Nov 2007 14:12:28 +0900
Message-ID: <1194153148.3112.15.camel@raven.themaw.net>
References: <D31A6D71-AB0C-45C0-A371-66AB549253BE@isolar.dyndns.org>
	<1192780957.24353.10.camel@raven.themaw.net>
	<4718AF15.3090204@everyzing.com>
	<1192804644.24353.32.camel@raven.themaw.net>
	<x49lk9zqgcp.fsf@segfault.boston.devel.redhat.com>
	<4718E3F6.4010606@everyzing.com>
	<1192814519.24353.56.camel@raven.themaw.net>
	<472C9347.4060600@everyzing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <472C9347.4060600@everyzing.com>
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
To: Dan Halbert <halbert@everyzing.com>
Cc: autofs@linux.kernel.org

On Sat, 2007-11-03 at 11:27 -0400, Dan Halbert wrote:
> Ian,
> 
> I see that http://rhn.redhat.com/errata/RHSA-2007-0939.html, dated 
> 2007-11-01, claims to include a fix for autofs bug 248126, with a new 
> kernel-2.6.9-55.0.12. Do you know if this kernel contains effectively 
> the same patches that are in the test kernel I got from you? If so, 
> great! We have been running your test kernel on about thirty machines 
> with no problems, no ENOENT's, etc.

Yep, it looks good to me.

Ian
