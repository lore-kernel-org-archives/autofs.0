From: Peter Staubach <staubach@redhat.com>
Subject: Re: Has replicated mount failover  been implemented?
Date: Fri, 12 Oct 2007 07:35:41 -0400
Message-ID: <470F5C0D.9030901@redhat.com>
References: <430834.18700.qm@web81808.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <430834.18700.qm@web81808.mail.mud.yahoo.com>
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
To: John Simon <tzzhc4@yahoo.com>
Cc: autofs@linux.kernel.org

John Simon wrote:
> We have two pairs of VCS HA-NFS servers (one in each
> data center), so each entry in auto_appl is the VIP
> for the HA pair. Should one portion of the cluster in
> the data center local to the compute engines fail it
> will just fail over to the other cluster node and
> client-side failover would not be used. If however the
> entire cluster fails or is unavailable for whatever
> reason the duplicate VCS HA-NFS server in the other
> data center resumes serving data, albeit at a slightly
> slower rate due to latency over the MAN. This site to
> site failover is where we currently depend on Solaris
> client-side failover.

Ahhh.  Okay, thanx!

       ps
