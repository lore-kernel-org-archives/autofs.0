From: Steve Thompson <smt@vgersoft.com>
Subject: bind mounts apparently not working
Date: Sun, 24 Feb 2008 09:13:40 -0500 (EST)
Message-ID: <alpine.LRH.0.9999.0802240858190.1590@vger.vgersoft.com>
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

CentOS 5.1, i686, 2.6.18-53.1.13.el5 SMP, autofs-5.0.1-0.rc2.55.el5.3. 
Fully updated. Two processors. Multi-homed system (3 interfaces, DNS 
reports all IP/names in both directions). Server is also a NIS master and 
DNS server.

Automounting of file systems on the server is apparently going through the 
NFS stack w/o a bind mount:

In /etc/auto.master:
 	+auto.master

In the NIS auto.master map:
 	/fs/home auto.home rw,rsize=32768,wsize=32768

In the NIS auto.home map:
 	username  server-fqdn:/local/home/path/&

So, on doing a "cd /fs/home/username", we get an NFS mount:

 	server-fqdn:/local/home/path/username on /fs/home/username type
 		nfs (rw,rsize=32768,wsize=32768,addr=one-of-server-IP)

Everything works fine, but doing, for example, a large "make -j2" within 
/fs/home/username results in several nfsd threads consuming approximately 
80% of one CPU, and performance drops through the floor. Autofs not 
recognizing the server-fqdn as the name corresponding to the primary IP on 
each interface? Worked properly with autofs4. Thoughts? TIA,

-steve
