From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Autofs question
Date: Wed, 14 Jan 2004 17:23:28 +0100
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200401141723.28338.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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

Hi,

1) I grabbed the Dieter Demerre's auto.smb script for mounting samba/windows shares making life hellofalot simpler
when it comes to accessing Windows shares.

One of the flaws is that I'd like to get around is that it must be configured as root, as opposed to by the user who
wants to access a share, and most importantly  that I don't see who is requesting the mount. I was thinking along 
the line of mounting shares in /cifs/$USER/servers/share or simply mounting the share for the first user using the mount 
point (essentially single user or one-user-at-a-time machines anyway).

the auto.smb script is running as root and I printed some info in root.c at the revalidate

Jan 12 18:49:06 h6n2fls33o811 kernel: autofs4_root_revalidate, uid=505 name=10.1.1.4
Jan 12 18:49:06 h6n2fls33o811 automount[22233]: attempting to mount entry /cifs/10.1.1.4
Jan 12 18:49:06 h6n2fls33o811 kernel: autofs4_root_revalidate, uid=0 name=10.1.1.4
Jan 12 18:49:06 h6n2fls33o811 logger: uid=0(root) gid=0(root) grupper=0(root)
Jan 12 18:49:07 h6n2fls33o811 kernel: autofs4_root_revalidate, uid=0 name=10.1.1.4
Jan 12 18:49:08 h6n2fls33o811 last message repeated 10 times
and lots more from mounting with uid=0

Is there any simple way of passing the first uid to the automounter daemon?

2) Another anoying thing with autofs is that it mounts all shares on the machine which is a problem
when I don't have access to all.

3) How can the returned map handle spaces in the share names?

I'm using vanilla kernel 2.6.1 and autofs tools 4.0.0 as they come on Mandrake Cooker.

-- robin
