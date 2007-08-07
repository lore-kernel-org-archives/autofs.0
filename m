From: Ian Kent <raven@themaw.net>
Subject: Re: AutoFS5 RPM version
Date: Tue, 07 Aug 2007 10:45:38 +0800
Message-ID: <1186454738.3320.0.camel@raven.themaw.net>
References: <46B23DFB.7060200@cs.ou.edu>
	<x49odhpek9z.fsf@segfault.boston.devel.redhat.com>
	<46B247E7.3020902@cs.ou.edu> <1186111734.3573.1.camel@raven.themaw.net>
	<46B78FAC.9040807@cs.ou.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <46B78FAC.9040807@cs.ou.edu>
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
To: jsummers@bachman.cs.ou.edu
Cc: autofs@linux.kernel.org

On Mon, 2007-08-06 at 16:16 -0500, Jim Summers wrote:
> Ian Kent wrote:
> > On Thu, 2007-08-02 at 16:08 -0500, Jim Summers wrote:
> >> Jeff Moyer wrote:
> >>> Jim Summers <jsummers@bachman.cs.ou.edu> writes:
> >> i do have the following installed:
> >>
> >> autofs-5.0.1-20
> >> autofs-debuginfo-5.0.1-20
> >>
> >> and by the way, i am building those from source rpms. before i actually do an 
> >> rpmbuild i run a patch that Ian had sent me.  it fixes a syntax issue when you 
> >> have a dc that is named ou.  after the last updates it quit working, so i 
> >> grabbed the src.rpm and rebuilt again.  i guess the patch hasn't made into the 
> >> repos yet.
> > 
> > That is in autofs-5.0.2-21 which should be on the mirrors.
> 
> Hi Ian,
> 
> I was able to pick up the autofs with the 'dc=ou' patch in it on an FC7 
> installation I have.  But when I tried a yum -y update on an FC6 machine it 
> updated to:  autofs-5.0.1-0.rc3.32, which does not seem to have the patch in 
> it.  Do you know if the FC6 repos's will have the patched version?

Sorry, I'll get onto it.

Ian
