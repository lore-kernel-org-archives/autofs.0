From: Justin Rush <jrush@scout.wisc.edu>
Subject: Passing the automounter mount options
Date: Fri, 3 Oct 2003 10:28:37 -0500 (CDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0310031023200.17845-100000@fromage.scout.wisc.edu>
Mime-Version: 1.0
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

Hi,
  I am troubleshooting nfs performance and I am trying to pass some 
options to the automounter.  We are using NIS with an auto.home file to 
automount user's homedirectories.  I have a line like :
jrush -rw,soft,rsize=32768,wsize=32768,nfsvers=3 host:/path/to/home
However it does not seem to work because I do not get the same perfermance 
as when I do an nfs mount manually, ie. mount -t nfs host:/path dir/ -o 
rsize=32768,wsize=32768,nfsvers=3

Am I missing something here or just editing the wrong file?

Any input is greatly appreciated.

-- 
Justin Rush
Technical Specialist
Internet Scout Project
jrush@scout.wisc.edu
