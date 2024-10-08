# วิธีการติดตั้ง

1. ดาวน์โหลด source code ใส่ไว้ใน folder ที่ต้องการ เช่น folder workspaces
   ```
   git clone https://github.com/ecosoft-odoo/nxpo_frappe.git -b main
   ```
2. เข้าไปใน folder nxpo_frappe
   ```
   cd <workspace directory>/nxpo_frappe
   ```
3. Ignore frappe_docker submodule
   ```
   git config submodule.frappe_docker.ignore all
   ```
4. ดาวน์โหลด source code จาก frappe_docker repository
   ```
   git submodule init && git submodule update --remote
   ```
5. แก้ไข export SITES=("...") ในไฟล์ install.sh ตาม url ที่เข้าระบบ เช่น ถ้าเข้าระบบด้วย url erp.ecosoft.co.th จะตั้งค่าเป็น export SITES=("erp.ecosoft.co.th")
6. รัน script install.sh เพื่อติดตั้งระบบ
   ```
   bash install.sh
   ```
7. ตั้งค่า https โดยใส่ไฟล์ cert ที่ path /var/lib/docker/volumes/nxpo-frappe_cert-data/_data ซึ่งประกอบด้วย 2 ไฟล์ คือ server.crt และ server.key
8. เข้าระบบผ่าน url เช่น https://erp.ecosoft.co.th

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
   bash install.sh
   ```
3. ตรวจสอบ Apps ทั้งหมด
   ```
   docker compose --project-name nxpo-frappe -f docker-compose.yaml exec backend ls apps
   ```

**NOTE**

ในขั้นตอนนี้จะใช้เวลาในการดำเนินการนาน เพราะว่าก่อนการดาวน์โหลด Apps ระบบจะอัพเดท Version ของ ERPNEXT ให้ล่าสุดก่อน

# วิธีการ Install Apps

1. รัน script bench.sh แล้วตามด้วยคำสั่ง --site [site-name] install-app [app-name]
   ```
   bash bench.sh --site erp.ecosoft.co.th install-app hrms wiki
   ```

# วิธีการ Update Apps

1. รัน script bench.sh แล้วตามด้วยคำสั่ง --site [site-name] migrate
   ```
   bash bench.sh --site erp.ecosoft.co.th migrate
   ```
