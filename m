From: Thomas Jahns <Thomas.Jahns@gmx.net>
Subject: automount doesn't reread file map, automount terminates on empty
 file map
Date: Sat, 11 Dec 2004 20:17:02 +0000
Message-ID: <1102796222l.6265l.2l@mercury>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; delsp="Yes"; format="Flowed"
To: autofs@linux.kernel.org

Hi,

I'm currently experimenting with a script-created map and face the  
following two problems:

- After the script rewrites the map, I need to kill -HUP the  
corresponding automount to reread the map, the documentation says the  
daemon would read a changed map on next access of the directory?

- Unfortunately there exists the possibility, that the script might  
leave the map empty. The corresponding automount process will then  
exit. Is there perhaps some comment convention or anything else I could  
do to keep the automount process running?

How can I solve this? The man-pages don't document the exit on empty  
map (or at least I haven't found a corresponding statement). What  
exactly triggers the rereading of file maps?

Thanks for any input on how to improve on the described situations.

Regards,
	Thomas Jahns
-- 
"Computers are good at following instructions,
 but not at reading your mind."
D. E. Knuth, The TeXbook, Addison-Wesley 1984, 1986, 1996, p. 9
