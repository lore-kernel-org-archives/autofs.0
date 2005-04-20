From: Jeffrey Layton <jtlayton@poochiereds.net>
Subject: RE: replicated mounts patch
Date: Wed, 20 Apr 2005 12:32:35 -0400
Message-ID: <1114014755.9683.42.camel@barsoom.rdu.redhat.com>
References: <482A3FA0050D21419C269D13989C6113085399F5@lavender-fe.eng.netapp.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <482A3FA0050D21419C269D13989C6113085399F5@lavender-fe.eng.netapp.com>
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
Content-Type: text/plain; charset="us-ascii"
To: "Lever, Charles" <Charles.Lever@netapp.com>
Cc: autofs@linux.kernel.org, raven@themaw.net

On Wed, 2005-04-20 at 09:13 -0700, Lever, Charles wrote:
> if the mount option default settings change (say it was 'udp' in earlier
> releases, and is now 'tcp') the meaning of a missing option on the mount
> command line is different.
> 
> so looking at the mount options is a completely unreliable way to
> determine which transport protocol is in use...
> 

True, but at least this makes some effort at it. The old code did a
UDP/NFSv2 ping no matter what. This is still what happens in the absence
of these mount options.

Is there some way to pull this info out of the mount program or the
kernel so we could determine the appropriate default at runtime? That
would be the best way to do it.

-- 
Jeffrey Layton <jtlayton@poochiereds.net>
