From: Rainer Krienke <krienke@uni-koblenz.de>
Subject: Re: Unable to mount with autofs-4.1.4: aquire_lock: can't
	lock lock file timed out: /var/lock/autofs
Date: Wed, 19 Oct 2005 08:22:03 +0200
Message-ID: <200510190822.03871.krienke@uni-koblenz.de>
References: <200510181321.08443.krienke@uni-koblenz.de>
	<Pine.LNX.4.61.0510180915020.8645@xena.cft.ca.us>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0510180915020.8645@xena.cft.ca.us>
Content-Disposition: inline
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org, Jim Carter <jimc@math.ucla.edu>

On Dienstag 18 Oktober 2005 18:44, you wrote:
> On Tue, 18 Oct 2005, Rainer Krienke wrote:
> > using the autofs package from suse10.0 (autofs-4.1.4-6.i586.rpm; autofs4
> > kernel module, Kernel2.6.13-15) NFS mounts of user directories fail ...
> > In auto.home there is this entry for each user like "krienke":
> >
> > krienke localhost:/import/user2/krienke
> >
> > In auto.vol you find another entry to handle the "user2" key starting at
> > /import from above (there are more than one nfsservers exporting user1,
> > user2, ... each with about 2000 users):
> >
> > user2 nfssrv2:/export/user2
> > Oct 18 12:42:30 rzinstal1 automount[16793]: aquire_lock: can't lock lock
> > file timed out: /var/lock/autofs
>
> Now that's a very neat solution to the problem of too many incoming /
> outgoing mounts.  But unfortunately you're doing the following sequence:
>
> User refers to /home/krienke
>     Autofs starts to mount /import/homesite/fsys/krienke, stats
> 	/import/homesite/fsys
> 	Second autofs thread starts to mount homesite:/export/fsys
> 	    Oops, an autofs thread has the lock, 2nd thread either blocks
> 	    waiting for the lock, or dies.  (The latter, judging from
> 	    timestamps.)
>
Thanks for the answer but I am not sure if this is the point, simply because 
this setup works an all other (older) machines eg with autofs 4.1.3. So it 
seems autofs had the capabilities to to hierachical mounts already but seems 
to have lost it in its current release. 

Have a nice day
Rainer
-- 
---------------------------------------------------------------------------
Rainer Krienke, Universitaet Koblenz, Rechenzentrum, Raum A022
Universitaetsstrasse 1, 56070 Koblenz, Tel: +49 261287 -1312, Fax: -1001312
Mail: krienke@uni-koblenz.de, Web: http://www.uni-koblenz.de/~krienke
Get my public PGP key: http://www.uni-koblenz.de/~krienke/mypgp.html
---------------------------------------------------------------------------
