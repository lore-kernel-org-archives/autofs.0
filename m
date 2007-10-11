From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Has replicated mount failover  been implemented?
Date: Thu, 11 Oct 2007 15:21:18 -0400
Message-ID: <x494pgx1mq9.fsf@segfault.boston.devel.redhat.com>
References: <145207.13740.qm@web81811.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <145207.13740.qm@web81811.mail.mud.yahoo.com> (John Simon's
	message of "Thu\, 11 Oct 2007 11\:50\:03 -0700 \(PDT\)")
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

John Simon <tzzhc4@yahoo.com> writes:

> Since client-side failover is not currently possible
> with Linux autofs does anyone have any recommendations
> for minimizing server side impact during when a HA-NFS
> server fails over. Right now what happens with HA-NFS
> is all the clients retry so much they basically end up
> DOS'ing the NFS server and causing it to failover
> again and again. We have hundreds of clients.

See the retry, retrans, and timeo nfs mount options.

Cheers,

Jeff
