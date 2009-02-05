From: Steve Thompson <smt@vgersoft.com>
Subject: autofs5 segfault
Date: Thu, 5 Feb 2009 12:06:09 -0500 (EST)
Message-ID: <alpine.LRH.0.9999.0902051202040.3273@honker.vgersoft.com>
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

CentOS 5.2 x86_64, kernel 2.6.18-92.1.22.el5, autofs-5.0.1-0.rc2.88.

Automount maps come from an OpenLDAP server. I have noticed that if I 
attempt to automount a file system that comes from a server that is 
currently down, /usr/sbin/automount reliably segfaults and exits, every 
time. I have core dumps, but they indicate a segfault and provide not much 
in the way of other useful information.

The same happens on CentOS 5.2 32-bit.

Steve
----------------------------------------------------------------------------
Steve Thompson                 E-mail:      smt AT vgersoft DOT com
Voyager Software LLC           Web:         http://www DOT vgersoft DOT com
39 Smugglers Path              VSW Support: support AT vgersoft DOT com
Ithaca, NY 14850
   "186,300 miles per second: it's not just a good idea, it's the law"
----------------------------------------------------------------------------
