# วิธีการติดตั้ง

1. ดาวน์โหลด source code ใส่ไว้ใน folder ที่ต้องการเช่น folder workspaces
   ```
   git clone https://github.com/ecosoft-odoo/nxpo_frappe.git -b main
   ```
2. เข้าไปใน folder nxpo_frappe
   ```
   cd &lt;workspace directory&gt;/nxpo_frappe
   ```
3. Ignore frappe_docker submodule จาก git
   ```
   git config submodule.frappe_docker.ignore all
   ```
4. ดาวน์โหลด source code จาก frappe_docker repository
   ```
   git submodule init && git submodule update --remote
   ```
5. แก้ไข site ตาม url ที่เข้าระบบตรงบรรทัด export SITE="...." เช่น ถ้าเข้าระบบด้วย url erp.ecosoft.co.th จะตั้งค่าบรรทัดนี้เป็น export SITE="erp.ecosoft.co.th"
6. รัน script install.sh เพื่อติดตั้งระบบ
   ```
   sh install.sh
   ```
7. เข้าระบบผ่าน url เช่น http://erp.ecosoft.co.th

# วิธีการ Download Apps

1. ใส่ url และ branch ที่จะดาวน์โหลดในไฟล์ apps.json
   ```json
   [
      {
         "url": "https://github.com/frappe/erpnext",
         "branch": "version-15"
      },
      {
         "url": "https://github.com/frappe/hrms",
         "branch": "version-15"
      },
      {
         "url": "https://github.com/frappe/payments",
         "branch": "version-15"
      }
   ]
   ```
2. รัน script install.sh
   ```
   sh install.sh
   ```
