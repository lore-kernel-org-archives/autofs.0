From: "Jeremy A. Rosengren" <jeremy@rosengren.org>
Subject: RHEL3 update 3 automounting.
Date: Thu, 09 Sep 2004 11:17:14 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <4140820A.5070002@rosengren.org>
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
Content-Type: text/plain; format="flowed"; charset="us-ascii"
To: autofs@linux.kernel.org

Over this past weekend, I updated machines to RHEL3 WS update 3.  I've 
noticed so far that they seem to have the replicated hosts bug that 
causes the client to mount the server that's listed first, rather than 
the server that's "closest".

Is this something I can expect to get solved soon for RHEL3?  Before I 
head off to file one, does anybody know if there's already a Bugzilla 
about it?

Thanks,

-- jeremy
