From: ramana <ramana@intraperson.com>
Subject: exporting autofs managed directory using NFS
Date: Thu, 24 Jun 2004 19:25:44 +0530
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40DADD60.5090201@intraperson.com>
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
To: autofs@linux.kernel.org, hpa@zytor.com


We are facing problems where /home is managed by autofs ( in Autodir ) 
but this directory is to to be exported using NFS.

Exactly reverse of what autofs supposed to do  -- lol

When tried to mount nfs exported home some where else, Persmission 
denied error is reported by nfs server.

-- 
http://www.intraperson.com
