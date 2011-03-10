From: Nye Liu <nyet@mrv.com>
Subject: "Use bind instead of nfs if host is localhost" feature is
 broken? removed?
Date: Thu, 10 Mar 2011 15:59:45 -0800
Message-ID: <20110310235943.GA19588@mrv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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
To: autofs@linux.kernel.org

I have been relying on the behavior that

foo	host:/export/foo

uses 'bind' if host is localhost, and 'nfs' otherwise...

i.e. if i am on the machine "host", /export/foo is mounted on /mnt/foo using
bind, but if i am not on "host", host:/export/foo is mounted on /mnt/foo
using nfs.

But the latest version of autofs no longer does that.

Do i have to use this everywhere now?

foo	(1),host(2):/export/foo

The behavior is more like what I expect, but it seems wasteful.

-- 
Nye Liu
nliu@mrv.com
(818) 772-6235x248
(818) 772-0576 fax

"Who would be stupid enough to quote a fictitious character?"
	-- Don Quixote
