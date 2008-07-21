From: Chris Walker <cwalker@pixar.com>
Subject: Re: statfs() and autofs
Date: Sun, 20 Jul 2008 22:00:59 -0700
Message-ID: <20080721050059.GW5858@pixar.com>
References: <20080715204839.GU5858@pixar.com>
	<1216179794.22783.46.camel@raven.themaw.net>
	<487D855B.8000405@loran.name>
	<Pine.LNX.4.64.0807201441330.3491@simba.math.ucla.edu>
	<20080721034112.GU5858@pixar.com>
	<1216615194.3093.8.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <1216615194.3093.8.camel@raven.themaw.net>
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
To: autofs@linux.kernel.org

From raven [07/20 21:43]:
> Just to be absolutely clear.
> 
> The "browse" or "--ghost option isn't being used, in oder to avoid mount
> storms, but we still see stat(2) and statfs(2) (et. al.) not wait for a
> mount to complete.
> 
> Is that right?
> Is anyone in a position to test a kernel patch?

This is what I'm seeing and I'm only running automount with the --debug
option. If I don't pass --ghost to automount, is there any other way
browsing is enabled?

-- 
Chris Walker -- cwalker@pixar.com
