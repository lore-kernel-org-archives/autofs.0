From: Piete Brooks <Piete.Brooks--autofs@cl.cam.ac.uk>
Subject: autofs as a tfs replacement?
Date: Thu, 19 Apr 2007 07:45:27 +0100
Message-ID: <E1HeQOV-0004VV-00@mta2.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs mailing list <autofs@linux.kernel.org>

[ apologies if this is a repeat, but I didn't notice getting my copy before ]

Is there a simple way to get autofs to behave like tfs to get:

	IF       /localdir/$key/ exists
	THEN use /localdir/$key/
	ELSE use server:/remotedir/$key/

I was hoping to use something like the multi-home mechanism which tried each 
path in order until one worked.

I can set it up by hand using

	d1	:/localdir/&
	d2	:/localdir/&
	*	-rw server:/remotedir/&

but that needs editing on each host as each /localdir/ is created.

I assume I can HACK it using a programme hook which looks to see if 
/localdir/& exists, but it would be much cleaner to use the multi-home style 
list. Is this possible?
