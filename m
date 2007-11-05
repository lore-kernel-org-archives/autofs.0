From: Michael <michael@kmaclub.com>
Subject: autofs5 patches for older kernels
Date: Mon, 05 Nov 2007 07:27:34 -0700
Message-ID: <472F2856.6090701@kmaclub.com>
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

Hello,

I am running an older SuSE SLES9 release.  It ships with autofs-4.1.3 
with a 2.6.5 kernel.

We are having a number of issues with the automount daemon dying on 
certain mounts, failing to be responsive, etc in a rather large 
environment. 

We would like to upgrade to autofs5 but the kernel shipped ( 2.6.5 ) 
doesn't include support for autofs5 or a great number of patches that 
have gone into 2.6.16+ kernels.

Is anyone maintaining a current autofs patch set against older 2.6.x 
kernels?

Michael
