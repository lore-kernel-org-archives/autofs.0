From: Hans Deragon <hans@deragon.biz>
Subject: Autofs and unrecognized parameters... mount() not ignoring anymorefor
 2.6 kernel?
Date: Fri, 03 Sep 2004 15:27:31 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <4138C5A3.10107@deragon.biz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

Greetings.


   I use the same source code for two systems, RHL 9 and FC2.  Its Autofs 
4.1.3 with my infamous backfstype patch.

   RHL 9 runs kernel 2.4.20-28.9 while FC2 runs 2.6.6-1.435.  On RHL 9, autofs 
runs nicely.  On FC2, it complains about unrecognized parameters.  This 
happens when I try to mount from yp maps that are meant for Solaris.

   Is this a known issue?  Seams that the mount function does not ignore 
unrecognized parameters anymore under the 2.6 kernel.

   Currently, my quick fix is to change /etc/init.d/autofs to catch the 
unrecognized parameters.  These are "quota" and "nobrowse".


Best regards,
Hans Deragon
--
Consultant en informatique/Software Consultant
Deragon Informatique inc.     Open source:
http://www.deragon.biz        http://facil.qc.ca (Promotion du libre)
mailto://hans@deragon.biz     http://autopoweroff.sourceforge.net (Logiciel)
