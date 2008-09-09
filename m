From: Matthew Jurgens <autofs@edcint.co.nz>
Subject: Not correctly mount SMB shares ending in $
Date: Tue, 09 Sep 2008 14:01:28 +1000
Message-ID: <48C5F518.9010800@edcint.co.nz>
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
To: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

Hi

I recently upgraded to Fedora 9 and autofs-5.0.3-15.i386.
I use SMB shares ending in $ quite often and have noticed that in this 
release they are broken.
They are mounting in the wrong place. Contrast the 2 shares  below, one 
the C share, the other the C$ share. The wrong slash is in the remote 
service name

Autofs mounted:
//xp0/C on /smb/xp0/C type cifs (rw,mand)               <--- this one 
workes ok
//xp0/C/$ on /smb/xp0/C$ type cifs (rw,mand)          <----- this one is 
broken

Manually mounted and working:
//xp0/C$ on /mnt type cifs (rw,mand)
