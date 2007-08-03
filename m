From: Ian Kent <raven@themaw.net>
Subject: Re: AutoFS5 Ldap base strangeness
Date: Fri, 03 Aug 2007 11:28:54 +0800
Message-ID: <1186111734.3573.1.camel@raven.themaw.net>
References: <46B23DFB.7060200@cs.ou.edu>
	<x49odhpek9z.fsf@segfault.boston.devel.redhat.com>
	<46B247E7.3020902@cs.ou.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <46B247E7.3020902@cs.ou.edu>
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

On Thu, 2007-08-02 at 16:08 -0500, Jim Summers wrote:
> Jeff Moyer wrote:
> > Jim Summers <jsummers@bachman.cs.ou.edu> writes:
> i do have the following installed:
> 
> autofs-5.0.1-20
> autofs-debuginfo-5.0.1-20
> 
> and by the way, i am building those from source rpms. before i actually do an 
> rpmbuild i run a patch that Ian had sent me.  it fixes a syntax issue when you 
> have a dc that is named ou.  after the last updates it quit working, so i 
> grabbed the src.rpm and rebuilt again.  i guess the patch hasn't made into the 
> repos yet.

That is in autofs-5.0.2-21 which should be on the mirrors.

Ian
