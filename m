From: Chris Walker <cwalker@pixar.com>
Subject: Re: statfs() and autofs
Date: Sun, 20 Jul 2008 20:41:12 -0700
Message-ID: <20080721034112.GU5858@pixar.com>
References: <20080715204839.GU5858@pixar.com>
	<1216179794.22783.46.camel@raven.themaw.net>
	<487D855B.8000405@loran.name>
	<Pine.LNX.4.64.0807201441330.3491@simba.math.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0807201441330.3491@simba.math.ucla.edu>
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

From jimc [07/20 15:31]:
> Actually, only the sysop knows which is more important: doing the mount 
> storm to respond to stat() or statfs(), or avoiding the storm.

Agreed. In our case, we have 'heavily discouraged' use of /net on our
big servers and we would prefer that statfs()/stat() waited for the
automount to complete.

-- 
Chris Walker -- cwalker@pixar.com
