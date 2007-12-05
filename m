From: Jim Carter <jimc@math.ucla.edu>
Subject: knfsd: EINVAL errors on first access of new filesystem
Date: Wed, 5 Dec 2007 09:09:09 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0712050854410.4771@simba.math.ucla.edu>
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

I'm not having this problem, but it sounds possibly related to some 
trouble other people have reported...  While scanning online updates for 
OpenSuSE 10.3 I spotted this one in their update number 4749 for the 
kernel package:

++ patches.fixes/nfsacl-retval.diff: knfsd: fix spurious
 EINVAL errors on first access of new filesystem  [#340873]

I didn't do any further research to track down URLs and find out exactly 
what problem is being fixed, but others may be interested to do so.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
