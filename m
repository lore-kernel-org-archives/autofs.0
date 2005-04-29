From: Chris Fanning <christopher.fanning@gmail.com>
Subject: samba stop and autofs stop
Date: Fri, 29 Apr 2005 16:49:12 +0200
Message-ID: <215ff441050429074949954080@mail.gmail.com>
Reply-To: Chris Fanning <christopher.fanning@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs@linux.kernel.org

Hello all,

I have a server running samba for some windows clients.
Now, one the same client network, I am setting up some thin clients
that open their desktop session, in this case, the same server that's
running samba.

Because I've got some windows and some thin clients running kde, samba
is still necesary.

Some of the samba shares are common to all users so I'm trying to use
autofs to mount them.

It works but.
When I shutdown the server it freezes. It seems to be because the
samba server is shutdown before automount. Does that sound right?

Thank you.
Chris.
