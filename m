From: Stew Smith <stew.smith@sun.com>
Subject: Re: Status of >800 mounts
Date: Mon, 14 Jun 2004 16:30:57 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20040614233056.GA8964@birki.west.sun.com>
References: <409A7A7C.2000109@sedona.intel.com>
	<20040506185528.GA5149@crashy.west.sun.com>
	<40CE2D06.4070007@sedona.intel.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <40CE2D06.4070007@sedona.intel.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

On Mon, Jun 14, 2004 at 03:56:06PM -0700, Michael Blandford wrote:
> Stew Smith wrote:
> 
> >i am working on a patch currently which multiplexes nfs connections
> >per sever so you end up with a 800 server limit, similar to the
> >way nfsv4 works now.. i will send it out for review very soon after
> >i ferret out a few bugs.
> >
> >another idea we had was to add SO_REUSEADDR to rpc sockets so
> >you have more available on a busy system.
> >
> > 
> >
> any updates on this patch? 

we have code ready for review and testing but are awaiting
legal clearance to release it by Sun.

i will send it out the momment i am able to do so.

thanks,

--Stew
