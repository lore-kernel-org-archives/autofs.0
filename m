From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: ldap syntax issue in 5.0.3 ?
Date: Fri, 05 Dec 2008 19:07:45 +0100
Message-ID: <49396DF1.7060902@inria.fr>
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

According to https://qa.mandriva.com/show_bug.cgi?id=45984, the old 
ldap:servername:mapname syntax, documented in auto.master man page, 
doesn't work correctly in the autofs package shipped in mandriva 2009 
(5.0.3 + all official patches until 
autofs-5.0.3-fix-couple-of-memory-leaks.patch applied).
-- 
Guillaume Rousse
Moyens Informatiques - INRIA Futurs
Tel: 01 69 35 69 62
