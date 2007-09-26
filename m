From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] 5.0.0_beta1: uncomment "-f --foreground..."
	help text; comment out unused stuff.
Date: Wed, 26 Sep 2007 23:08:27 +0800
Message-ID: <1190819307.12109.2.camel@raven.themaw.net>
References: <200709261048.48044.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200709261048.48044.vda.linux@googlemail.com>
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
To: Denys Vlasenko <vda.linux@googlemail.com>
Cc: autofs@linux.kernel.org

On Wed, 2007-09-26 at 10:48 +0100, Denys Vlasenko wrote:
> Hi Ian,
> 
> Please apply attached trivial patch. It is run-tested.

Sorry I'm so late with this Denys but please look at commit
http://git.kernel.org/?p=linux/storage/autofs/autofs.git;a=commitdiff;h=4bfe89a5c214859eb07ad1aa7e4481d470a5bb3f

I think this will cover the foreground logging issues you're having.
The patch is also in the usual place on kernel.org.

Ian
