From: Jeremy Rosengren <jeremy.rosengren@gmail.com>
Subject: Replicated hosts in autofs v4.
Date: Sun, 10 Oct 2004 11:18:54 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <bf092570041010091873f86c2f@mail.gmail.com>
Reply-To: Jeremy Rosengren <jeremy.rosengren@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs@linux.kernel.org

I've previously posted about this problem, but I still haven't found
an answer, although I think I better understand what's happening.

We have an automount map called "auto_group" that looks like this:

icdes     ausfiler,minnfiler:/vol/vol0/data/group/&

ausfiler lives in Texas, minnfiler lives in Minnesota.  Between
ausfiler and minnfiler lies a T1 line.

On the MInnesota office network, from a RedHat Enterprise 3.0 Update 3
client (using autofs-4.1.3-12), cd'ing into /group/icdes mounts
ausfiler:/vol/vol0/data/group/icdes.  No matter what...it always
mounts ausfiler.  The problem is that ausfiler is on the other end of
a T1 from the client, whereas minnfiler is on the same subnet, on the
same network switch.

I filed a support ticket with RedHat Global support, and an engineer
there confirmed that the client does an RPC call with a  .1 second
timeout.  However, the client's behavior indicates to me that the
comparison being made in the reponse times between the replicated
mount servers isn't fine-grained enough to make the correct choice.  A
coworker made the comment that our T1 line could be "too robust",
making the server farther away appear to be good enough for the
client's purposes.

Solaris doesn't seem to have any issues with doing this properly.  A
Solaris client in Minnesota will always mount the "closest" server in
a replicated host map, which is important because we're trying to use
RHEL3 to replace some of our Solaris infrastructure.  The RH Global
support engineer suggested reversing the order of the servers in the
map, however that would cause clients in Texas to exhibit the same
behavior that clients in Minneapolis are.

Can somebody explain to me whether I'm not the right track in
understanding the problem, with regards to the comparison not being
fine-grained enough for the client to make the correct choice?  Or,
might there be something else going on?  I previously had assumed that
the behavior I was seeing was related to the bug that caused the
client to always mount the first-listed server, but I no longer think
that's the case.

Thanks,

-- jeremy
