From: "Francesco P. Lovergine" <f.lovergine@ba.issia.cnr.it>
Subject: Looking for a per user submount...
Date: Mon, 28 Jan 2008 11:11:53 +0100
Message-ID: <20080128101153.GE5803@mithrandir>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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

I was looking for some sort of automounting for per-user subtrees.
Essentially I need to bind-mount on demand some per user (users are sql-based)
subdir like /path/<user>/mount_point, where /path/<user> is a true dir. 
I'm missing something or it cannot be performed using autofs without
adding each entry explicitly for every users ?

-- 
Francesco P. Lovergine
