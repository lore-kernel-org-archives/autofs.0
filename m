From: Steve Thompson <smt@vgersoft.com>
Subject: autofs breakage & fix
Date: Tue, 18 Dec 2007 16:14:53 -0500 (EST)
Message-ID: <alpine.LFD.0.9999.0712181504550.31763@honker.vgersoft.com>
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

FYI,

I upgraded an x86 CentOS 4.5 client system (autofs-4.1.3-199.3) to CentOS 
4.6 (autofs-4.1.3-231), no other changes, and autofs broke. Maps come from 
an LDAP server, for example:

  dn: cn=common,nisMapName=auto.xxx,dc=example,dc=org
  objectClass: nisObject
  cn: common
  nisMapName: auto.xxx
  nisMapEntry: server:/mnt/mda/data1/common -rw,rsize=32768,wsize=32768

When attempting to automount this, the client is passing the mount path, 
_including the options_, to the server as the path to be mounted, and the 
server of course says "no such file and directory". This works on 4.5.

If the nisMapEntry field is rewritten to put the options first:

  nisMapEntry: -rw,rsize=32768,wsize=32768 server:/mnt/mda/data1/common

then it works on both versions of the OS. So something is less tolerant
in parsing in 4.6.

Steve
