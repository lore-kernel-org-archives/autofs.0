From: Steve Thompson <smt@vgersoft.com>
Subject: Re: statfs() and autofs
Date: Mon, 21 Jul 2008 11:26:10 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0807211118220.1933@honker.vgersoft.com>
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

On Mon, 21 Jul 2008, Ian Kent wrote:

> Just to be absolutely clear.
>
> The "browse" or "--ghost option isn't being used, in oder to avoid mount
> storms, but we still see stat(2) and statfs(2) (et. al.) not wait for a
> mount to complete.

I see this problem quite often. I have a CentOS 5.2 x86_64 system with 
autofs-5.0.1-0.rc2.88, kernel 2.6.18-92.1.6.el5xen. Automount maps are 
distributed by NIS, and I have explicitly set BROWSE_MODE=no. I see that:

* after an inactive mount times out, an umount is performed, but the mount
   point that was created is never removed, leading to:

* if the NIS map is changed to point the same key to a different location,
   a "df /foo/bar" _always_ returns /foo, and then /foo/bar (correctly) a
   few moments later.

Steve
