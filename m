From: John Simon <tzzhc4@yahoo.com>
Subject: Re: Has replicated mount failover  been implemented?
Date: Thu, 11 Oct 2007 11:50:03 -0700 (PDT)
Message-ID: <145207.13740.qm@web81811.mail.mud.yahoo.com>
References: <836836.16914.qm@web81813.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <836836.16914.qm@web81813.mail.mud.yahoo.com>
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

Since client-side failover is not currently possible
with Linux autofs does anyone have any recommendations
for minimizing server side impact during when a HA-NFS
server fails over. Right now what happens with HA-NFS
is all the clients retry so much they basically end up
DOS'ing the NFS server and causing it to failover
again and again. We have hundreds of clients.



--- John Simon <tzzhc4@yahoo.com> wrote:

> We are in the process of switching from Sun blades
> to
> Linux blades for our compute farm and are running
> into
> issues with automount not failing over when an NFS
> server goes down. I am wondering if it is a
> configuration issue, if I am using a version of
> autofs
> that doesn't support failover or if it hasn't been
> implemented yet.



       
____________________________________________________________________________________
Looking for a deal? Find great prices on flights and hotels with Yahoo! FareChase.
http://farechase.yahoo.com/
