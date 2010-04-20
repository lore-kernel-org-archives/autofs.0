From: Stef Bon <stef@bononline.nl>
Subject: About reading events from /dev/autofs
Date: Tue, 20 Apr 2010 11:44:42 +0200
Message-ID: <4BCD778A.7070707@bononline.nl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

  Hello,

earlier I've written a testprog to read /dev/autofs. It did not work:

http://linux.kernel.org/pipermail/autofs/2010-March/006071.html

Is there a way to watch /dev/autofs (with select or epoll) from within my C
program?

Stef
