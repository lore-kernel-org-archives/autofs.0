From: jansen <jansen@astro.wisc.edu>
Subject: autofs not unmounting mount points?
Date: Fri, 12 Mar 2004 09:46:01 -0600
Sender: autofs-bounces@linux.kernel.org
Message-ID: <4051DB39.4060905@astro.wisc.edu>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org


Hi,

I've been struggling to figure out why autofs does not appear
to unmount many mount points.  I have more than 150 entries in
a map file and most of these entries get mounted when I log into
a Gnome session and never seem to ever get unmounted.  This
happened under RedHat 8.0 (autofs-3.1.7-33) and still happens on
SuSE 9.0 (autofs-3.1.7-717).  I'm guessing that Nautilus is doing
this.  Is anyone else seeing this?  Any suggestions on how to prevent
or debug this?  I can provide more details if anyone is interested.

-- 


------- Stephan
