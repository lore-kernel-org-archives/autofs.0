From: Clif Smith <kernel@cjs226.com>
Subject: Can I "null" out NIS maps with autofs?
Date: Mon, 30 Aug 2004 23:38:27 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <413400C3.2010203@cjs226.com>
Mime-Version: 1.0
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
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

Occasionally I need to use all but 1 or 2 NIS maps with automount.  With 
AIX and Solaris, I've been able to use the -null arg.  However that 
doesn't seem to work with autofs?

cjs
