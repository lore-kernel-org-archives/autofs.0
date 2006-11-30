From: Frank Thommen <fthommen@embl.de>
Subject: No include of NIS maps in automounter maps possible any
	more?
Date: Thu, 30 Nov 2006 14:45:11 +0100
Message-ID: <456EE067.3090208@embl.de>
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
To: autofs@linux.kernel.org

Hi,

I hope this question is not too basic for this list, but I could not 
find any answer in the list archives or through friend google.

With automount version 4.1.3-187 (running on CentOS 4.4) I could have an 
automounter map (not auto.master) to be like:

key1   host1:/path1
key2   host2:/path2
+map.in.nis

This way I could add specific local mounts to a generally available NIS 
map or override NIS given keys with my own ones.

With automount 4.1.4-33 (on Fedora Core 5) this doesn't work any more. 
The additional map is simply ignored.  I tried with '+map.in.nis' and 
'+yp:map.in.nis' to no avail.

'automount' in nsswitch.conf is on 'files nis' in both cases.


Is this a bug or a wanted feature in 4.1.4?  Is there an other way to 
*combine* nis and local maps for automounting?  We have configured a lot 
of hosts with above setup and whith the current OS-updates this starts 
to break.


Any hints or pointers are appreciated.

Thanks you very much

    frank
