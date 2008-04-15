From: Ian Kent <raven@themaw.net>
Subject: Re: user reporting memory leak with ldap maps
Date: Tue, 15 Apr 2008 11:04:40 +0800
Message-ID: <1208228681.3101.8.camel@raven.themaw.net>
References: <48036EE7.3070805@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <48036EE7.3070805@inria.fr>
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
To: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Cc: autofs@linux.kernel.org


On Mon, 2008-04-14 at 16:49 +0200, Guillaume Rousse wrote:
> A mdv user complains about a memory leak in autofs 5.0.2. I can't
> reproduce myself, but I don't have the same version available for testing.
> 
> See https://qa.mandriva.com/show_bug.cgi?id=39911 for full report.

That's quite possible but why hasn't any pertinent information been
obtained from the reporter?

What are the maps in use?
What is the memory usage at startup, after 2 hours, 4 hours, at least
two samples the following day, etc. (for at least two days)?
Does the same thing happen if they setup file maps for everything
instead?

What process did you follow when trying to reproduce it?

As far as the version goes I don't know what may have been added to make
up that package.

Ian
